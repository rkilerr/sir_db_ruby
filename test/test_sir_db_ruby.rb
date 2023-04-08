# frozen_string_literal: true

require "test_helper"

class TestSirDbRuby < Minitest::Test
  @@db_name = "sir_db"
  def test_that_it_has_a_version_number
    refute_nil ::SirDbRuby::VERSION
  end

  def test_get_config
    SirDbRuby.config(@@db_name)
    assert_equal true, Dir.exist?("#{Dir.pwd}/#{@@db_name}")
  end

  def test_get_table
    SirDbRuby.config(@@db_name)
    user = SirDbRuby.get_table("users")

    refute_nil user
    assert_equal true, Dir.exist?("#{Dir.pwd}/#{@@db_name}/users")
    assert_equal true, File.exist?("#{Dir.pwd}/#{@@db_name}/users/table_info.json")
  end

  def test_drop_table
    SirDbRuby.drop_table("users")
    assert_equal false, Dir.exist?("#{Dir.pwd}/#{@@db_name}/users")
    assert_equal false, File.exist?("#{Dir.pwd}/#{@@db_name}/users/table_info.json")
  end

  def test_put_table
    users = SirDbRuby.get_table("users")
    users.put("1", { name: "Alex", age: "19" })

    refute_nil users.get("1")
  end
end
