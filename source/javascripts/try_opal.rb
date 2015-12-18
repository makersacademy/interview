require 'opal'
require 'opal-parser'
require 'opal-jquery'

require_relative 'default_try_code'
require_relative 'stage_1'
require_relative 'stage_2'

class TryOpal
  class Editor
    def initialize(dom_id, options)
      @native = `CodeMirror(document.getElementById(dom_id), #{options.to_n})`
    end

    def value=(str)
      `#@native.setValue(str)`
    end

    def value
      `#@native.getValue()`
    end
  end

  def self.instance
    @instance ||= self.new
  end

  def initialize
    @flush = []

    @output = Editor.new :output, lineNumbers: false, mode: 'text', readOnly: true
    @viewer = Editor.new :viewer, lineNumbers: false, mode: 'ruby', readOnly: true, theme: 'tomorrow-night-eighties'
    @editor = Editor.new :editor, lineNumbers: true, mode: 'ruby', tabMode: 'shift', theme: 'tomorrow-night-eighties', extraKeys: {
      'Cmd-Enter' => -> { run_code }
    }

    Element.find('#run_code').on(:click) { run_code }

    @editor.value = DEFAULT_TRY_CODE.strip

    begin_stage Stage1.new
  end

  def begin_stage(stage)
    @viewer.value = stage.display_code
    @stage = stage
  end

  def run_code
    @flush = []
    @output.value = ''

    begin
      ruby_code = @editor.value + "\n" + stage.code
      code = Opal.compile(ruby_code, :source_map_enabled => false)
      if eval_code code
        begin_stage stage.next_stage
      end
    rescue => err
      log_error err
    end
  end

  def eval_code(js_code)
    `eval(js_code)`
  end

  def log_error(err)
    puts "#{err}\n#{`err.stack`}"
  end

  def print_to_output(str)
    @flush << str
    @output.value = @flush.join('')
  end

  def stage
    @stage
  end
end

Document.ready? do
  $stdout.write_proc = $stderr.write_proc = proc do |str|
    TryOpal.instance.print_to_output(str)
    ycbm = Element.find('#youcanbookme')
    ycbm.css('display', str.include?('john') ? 'block' : 'none')
  end
  TryOpal.instance
end
