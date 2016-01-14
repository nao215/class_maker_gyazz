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
    File.write(file_path, ClassMakerGyazz::Make.new(text).html)
    puts file_path
    system "open #{file_path}"
    expect(true).to eq(true)
  end
end
