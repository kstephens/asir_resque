require 'asir'
# Added .asir support.
module Email
  include ASIR::Client # Email.asir
  def send_email template_name, options
    $stderr.puts "*** #{$$}: Email.send_mail #{template_name.inspect} #{options.inspect}"
    :ok
  end
  def do_raise msg
    raise msg
  end
  extend self
end

class MyClass
  include ASIR::Client
  def initialize x
    @x = x
  end
  def method_missing sel, *args
    @x.send(sel, *args)
  end
end

