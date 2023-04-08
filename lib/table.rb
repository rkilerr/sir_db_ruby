require "json"
require "digest"

class Table
  def initialize(table_info)
    if table_info.nil? || table_info.empty?
      raise Exception.new "Table constructor specify table_info"
    end

    @table_info = table_info
    puts(table_info[:table_base])
    @base = File.expand_path(File.dirname(table_info[:table_base]))
  end

  def put(key, record)
    key_hash = Digest::MD5.digest(key).inspect
    File.write("#{@base}/#{key_hash}.json", record.to_json)

    return record
  end

  def get(key)
    key_hash = Digest::MD5.digest(key).inspect

    record = JSON.parse(File.read("#{@base}/#{key_hash}.json"))

    return record
  end

  def get_all
    files = Dir.entries(@base)
    list = []
    files.delete("table_info.json")
    files.delete(".")
    files.delete("..")

    files.each do |file|
      list << JSON.parse(File.read("#{@base}/#{file}"))
    end
    return list
  end
end
