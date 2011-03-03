class FileIdGetter
  def self.get_from request
    matched = /GET \/files\/(.*)\/(.*)\/(\d*)\/(.*) HTTP/.match(request)
    return matched[3] unless matched.nil?

    matched = /GET \/files\/(.*)\/(.*)\/(\d*) HTTP/.match(request)
    return matched[3] unless matched.nil?

    matched = /GET \/files\/(\d*)\/(.*) HTTP/.match(request)
    return matched[1] unless matched.nil?

    matched = /GET \/files\/(\d*) HTTP/.match(request)
    return matched[1] unless matched.nil?

    return nil
  end
end

