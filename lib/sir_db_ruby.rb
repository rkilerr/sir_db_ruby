require_relative "sir_db_ruby/version"
require_relative "table"

module SirDbRuby
  @@root = nil
  INTERNAL_RECORD="table_info.json"

  def self.config(root = nil)
    @@root = root
    Dir.mkdir @@root if !Dir.exist?("#{Dir.pwd}/#{@@root}")
  end

  def self.get_table(table_name)
    return nil if @@root == nil
    Dir.mkdir("#{Dir.pwd}/#{@@root}/#{table_name}")
    info = ""
    begin
      info =
        JSON.parse(
          File.read("#{Dir.pwd}}/#{@@root}/#{table_name}}/#{INTERNAL_RECORD}")
        )
    rescue Errno::ENOENT
      info = {
        create_at: Time.new,
        table_base:
          File.expand_path("#{@@root}/#{table_name}/#{INTERNAL_RECORD}", Dir.pwd),
        name: table_name
      }

      File.write(
        "#{Dir.pwd}/#{@@root}/#{table_name}/table_info.json",
        info.to_json
      )
    ensure
      return Table.new(info)
    end
  end

  def self.drop_table(table_name)
    path = "#{Dir.pwd}/#{@@root}/#{table_name}"
    FileUtils.remove_dir(path) if Dir.exist?(path)
  end
end
