## Lua Math Parser
This is a Lua based math parsing utility.
### API Reference
```lua
--[[ 
Math Parser Api:
	_math:GetNumbers(string) -->> {number}
	_math.Add(string) -->> ?results and ?remaining | ?number
	_math.Subtract(string) -->> ?results and ?remaining | ?number
	_math.Percent(string) -->> ?results and ?remaining | ?number
	_math.Divide(string) -->> ?results and ?remaining | ?number
	_math.Multiply(string) -->> ?results and ?remaining | ?number
	_math.FormatMultiply(string) -->> string
	_math.Parentheses(string) -->> ?results and ?remaining | ?number
	_math:Caculate(string) -->> string
        _math.patterns --> {string}
-- Proper Usage:
        _math:Calculate(string) -->> string
--]]
```
### Usage
*Roblox LUA Specific*
```lua
-- Require the math parsing module.
local math = require(math_parser);

-- Examples
print(math:Calculate("5+5")); -- 10
print(math:Calculate("12/6")); -- 2
print(math:Calculate("1.5*10")); -- 15
```
### Contributors
[RigidStudios](https://github.com/RigidStudios), [T-R-I-X](https://github.com/T-R-I-X)
