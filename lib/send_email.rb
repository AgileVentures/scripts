require 'csv'
require 'byebug'
require 'ostruct'
require 'erb'

THUNDERBIRD = '/Applications/Thunderbird.app/Contents/MacOS/thunderbird'

NAME_INDEX = 0
EMAIL_INDEX = 1

def send_email
  preselectid = 'id1'
  subject = 'AgileVentures Charity and Professional Development'

  requestors = [['Sam', 'tansaku@gmail.com']]
  requestors.each do |requestor|
    
    name = requestor[NAME_INDEX]
    email = requestor[EMAIL_INDEX]
    to = email
    template = 'email.erb'
    file_path = File.join(File.dirname(__FILE__),template)
    namespace = OpenStruct.new(name: name,)
    body = ERB.new(File.read(file_path)).result(namespace.instance_eval { binding })
    options = %Q{"to='#{to}',preselectid='#{preselectid}',subject='#{subject}',body='#{body}'"}
    command = "#{THUNDERBIRD} -compose #{options}"
    puts command
    `#{command}`
  end
end