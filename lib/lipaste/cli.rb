require "thor"

require "lipaste/config"
require "lipaste/files"
require "lipaste/lichess"
require "lipaste/version"

module Lipaste
  class CLI < Thor
    desc "upload", "Upload a PGN."
    method_option :pgn,
      :aliases => "-p",
      :type => :string,
      :desc => "Specify a PGN file or string to upload."
    def upload
      conf = Lipaste::Config.read
      unless conf == nil
        begin
          cookie = Lipaste::Lichess.login conf[:username], conf[:password]
        rescue
          STDERR.puts "Error logging in to Lichess"
          exit 1
        end
      end

      if options.pgn == nil
        # Use a file from ~/Downloads by default
        pgn = File.read Lipaste::Files.get_latest_downloaded_pgn
      elsif File.exists? options.pgn
        # Read the file if a path is provided
        pgn = File.read options.pgn
      else
        # Treat any other argument as a PGN string
        STDERR.puts "Invalid PGN file: #{options.pgn}"
        exit 1
      end

      puts Lipaste::Lichess.upload cookie, pgn
    end
    default_task :upload

    desc "login", "Setup your Lichess username and password."
    def login
      Lipaste::Config.create_config
    end

    desc "logout", "Remove any saved Lichess username and password."
    def logout
      Lipaste::Config.destroy
    end

    desc "version", "Show version."
    map %w(-v --version) => :version
    def version
      say Lipaste::VERSION
    end
  end
end
