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

# def open_file(table_name)
#   info = ""
#   begin
#     info =
#       JSON.parse(
#         File.read("#{Dir.pwd}}/test-table/#{table_name}}/table_info.json")
#       )
#   rescue Errno::ENOENT
#     info = {
#       create_at: Time.new,
#       table_base:
#         File.expand_path("test-table/#{table_name}/table_info.json", Dir.pwd),
#       name: table_name
#     }

#     File.write(
#       "#{Dir.pwd}/test-table/#{table_name}/table_info.json",
#       info.to_json
#     )
#   ensure
#     return Table.new(info)
#   end
# end

# tab = open_file("users")
# tab.put("1", {name: "Alex", age: 19})
# users = tab.get_all
# p users

# i_t = open_file("users")
# p i_t.put("1", {name: "User"})
