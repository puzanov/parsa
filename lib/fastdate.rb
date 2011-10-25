require 'date'

class Fastdate 

 def initialize
   #[26/Apr/2011:23:59:43 +0000]
   @format = %r{(\d{2})/(\w{3})/(\d{4}):(\d{2}):(\d{2}):(\d{2}) \+(\d{4})}
 end

 def parse (string)
   string =~ @format
   day, month, year, hour, minute, second, tz = $1, $2, $3, $4, $5, $6, $7
   return Time.gm(year, month, day, hour, minute, second)
 end
end
