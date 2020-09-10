-- Author .Trix
-- Date 09/10/20 8:53am

local manager = {};
local parties = {};

--[[ 
Api:  
    manager.New(string,player,arguments) -->> object
    manager.Add(player,player) -->> success,error
    manager.Remove(player,player) -->> success,error
    manager.ChangeLeader(player,player) -->> success,error
    manager.ChangePosition(player,player) -->> success,error
    manager:Destroy(player,player) -->> success,error
]]

-- Services
local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")

-- Objects
local functions = {
  addToParty=Instance.new("RemoteFunction"),
  removeFromParty=Instance.new("RemoteFunction"),
  changePartyLeader=Instance.new("RemoteFunction"),
  changePlayerPosition=Instance.new("RemoteFunction"),
  destroyParty=Instance.new("RemoteFunction")
}

local objects = {
    partyNetwork=Instance.new("Folder")
}

-- ## Creating the objects listed in the objects table
for name,object in pairs(objects) do
    if name and object then
        object.Parent = replicatedStorage
        object.Name = name
    end
end

-- ## Creating the functions listed in the functions table
for name,function in pairs(functions) do
    if name and functionValue then
        functionValue.Parent = objects.partyNetwork
        functionValue.Name = name 
    end
end

warn("Party Manager: Created all assets!")

---------- Private functions -----------
local function warnGame(message,line)
    if not msg or not line then
        warn(script:GetFullName() .. " missing params: (line):" .. 20)
        return;
    end
    
    local message = script:GetFullName() .. " " .. msg ..": (line):" .. line

    warn(message)
    return; 
end

---------- Public functions -----------

-- .. Creates a defualt template for a party
manager.New = function (invitingPlayer,player)
    if not invitingPlayer or player then
        warnGame("Missing params",68)
        return;
    end
    
    -- add the code Rigid
end

-- .. Adds the player to the invitingPlayers' party
manager.Add = function (invitingPlayer,player)
    if not invitingPlayer or not player then
      warnGame("Missing params",78)
      return;
    end
    
    -- add the code Rigid
end

-- .. Removes the player from the kickingPlayers' party
manager.Remove = function (kickingPlayer,player)
    if not kickingPlayer or not player then
        warnGame("Missing params",88)
        return;
    end
    
    -- add the code Rigid
end

-- .. Changes the players position in the table index
manager.ChangePosition = function (player,newPosition)
    if not player or not newPosition then
        warnGame("Missing params",100)
        return;
    end
    
    -- add the code Rigid
end

-- .. Changes the party leader
manager.ChangeLeader = function (oldLeader,newLeader)
    if not oldLeader or not newLeader then
        warnGame("Missing params",110)
        return;
    end
    
    -- add code Rigid
end

-- .. Destroys the players' party
function manager:Destroy (player)
    if not player then
        warnGame("Missing params",120)
        return;
    end
    
    -- add code Rigid
end

return manager
