require "socket"

def parse_parameters(request_line)
  split_request = request_line.split
  http_method = split_request[0]

  split_request = split_request[1].split('?')
  path = split_request[0]

  params = {}
  split_request = split_request[1].split('&')
  split_request.each do |parameter|
    split_param = parameter.split('=')
    params[split_param[0]] = split_param[1]
  end

  return http_method, path, params
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  puts request_line

  http_method, path, params = parse_parameters(request_line)

  # #GET /?rolls=2&sides=6 HTTP/1.1

  puts http_method == "GET"
  puts path == "/"
  puts params == {"rolls" => "2",  "sides" => "6"}

  client.puts request_line
  client.puts "HTTP/1.1 200 OK\r\n\r\n"
  client.puts rand(6) + 1
  client.close
end
