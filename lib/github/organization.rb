require_relative '../github/client'

module Github
  class Organization
    def initialize name, token, max = 100
      @github = Client.new name, token, max
    end

    def gather_files file_path
      url_list = @github.contents_urls
                        .map { |name, url| [name, url.gsub('{+path}', file_path)] }
      files_from_all_repositories url_list
    end

    private

    def files_from_all_repositories file_urls
      Enumerator.new do |y|
        file_urls
          .each do |name, url|
          content = @github.get_file url

          y << [name, content] if content
        end
      end
    end
  end
end
