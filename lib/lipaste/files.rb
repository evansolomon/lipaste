module Lipaste
  class Files
    def self.get_latest_downloaded_pgn
      downloads = get_downloads_dir
      pgns = list_pgn_files downloads
      get_latest_file pgns
    end

    def self.get_downloads_dir
      home = File.expand_path "~"
      File.join home, "Downloads"
    end

    def self.list_pgn_files(dir)
      glob = File.join dir, "*"
      Dir.glob(glob).select {|f| f =~ /\.pgn$/}
    end

    def self.get_latest_file(files)
      mtimes = files.map {|f| {name: f, mtime: File.mtime(f)}}
      mtimes.sort! {|a, b| a[:mtime] - b[:mtime]}
      file = mtimes.pop
      file[:name]
    end
  end
end
