require "yaml"

module Lipaste
  class Config
    FILE_NAME = ".lipaste"

    def self.read
      return nil unless exists?

      content = File.read get_path
      YAML.load content
    end

    def self.get_path
      home = File.expand_path "~"
      File.join home, FILE_NAME
    end

    def self.exists?
      File.exists? get_path
    end

    def self.destroy
      File.delete get_path if exists?
    end

    def self.create_config
      puts "Your credentials will only be stored locally on your computer."
      print "Username: "
      username = $stdin.gets.chomp

      print "Password (text will be hidden): "
      `stty -echo`
      password = $stdin.gets.chomp
      `stty echo`

      _create_config username, password
    end

    def self._create_config(username, password)
      data = {username: username, password: password}
      File.write get_path, data.to_yaml
    end
  end
end
