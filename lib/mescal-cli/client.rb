module MescalCli
  class Client
    def initialize(host)
      @base_url = "http://#{host}/"
    end

    def task
      TaskClient.new(@base_url)
    end

    def slave
      SlaveClient.new(@base_url)
    end
  end

  class SlaveClient
    def initialize(base_url)
      @base_url = base_url + "slaves"
    end

    def get(id)
      RestClient.get "#{@base_url}/#{id}"
    end
  end

  class TaskClient
    def initialize(base_url)
      @base_url = base_url + "tasks"
    end

    def create(image, cmd, cpus, mem)
      RestClient.post @base_url, image: image, cmd: cmd, cpus: cpus, mem: mem, port: 22
    end

    def get(id)
      RestClient.get "#{@base_url}/#{id}"
    end

    def list
      RestClient.get "#{@base_url}"
    end

    def kill(id)
      RestClient.delete "#{@base_url}/#{id}"
    end
  end
end
