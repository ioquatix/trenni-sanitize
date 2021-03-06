# Copyright, 2018, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require_relative 'filter'

module Trenni
	module Sanitize
		class Text < Filter
			CLOSING = {
				"p" => "\n\n",
				"div" => "\n\n",
			}
			
			def filter(node)
				if node.name == "br"
					text("\n\n")
				end
				
				if node.name == 'script'
					node.skip!(ALL) # Skip everything including content.
				else
					node.skip!(TAG) # Only skip the tag output, but not the content.
				end
			end
			
			def close_tag(name, offset = nil)
				super
				
				if value = CLOSING[name]
					text(value)
				end
			end
			
			def doctype(string)
			end
			
			def comment(string)
			end
			
			def instruction(string)
			end
			
			def cdata(string)
			end
		end
	end
end
