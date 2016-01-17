require 'spec_helper'

describe ClassMakerGyazz do
  it 'has a version number' do
    expect(ClassMakerGyazz::VERSION).not_to be nil
  end

  it 'normally outputted from gyazz' do
    require 'pp'
    text = File.open(File.expand_path('../gyazz_texts/test.gyazz', __FILE__)) do |file| 
      file.read
    end
    file_path = File.expand_path("../html/" + "gyazz_html#{Time.now}.html".gsub("\/","\|").gsub(" ","_"), __FILE__)
    html = """
    <html>
      <head>
        <link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css'>
        <meta http-equiv='Content-Type' content='text/html; charset=utf-8'>
      </head>
      <body>
        #{ClassMakerGyazz::Make.new(text).html}
      </body>
    </html>
    """
    File.write(file_path, html)
    puts file_path
    system "open #{file_path}"
    expect(true).to eq(true)
  end
end
