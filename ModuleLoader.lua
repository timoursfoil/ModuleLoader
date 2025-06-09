-- Module Loader for Roblox
-- This script manages loading and requiring ModuleScripts stored in the server.
-- It provides safe loading with pcall and helper functions to check and require modules by name.

local ServerScriptService = game:GetService("ServerScriptService") 
-- Reference to ServerScriptService, the container where server scripts and modules are typically stored.

local ModuleFolder = ServerScriptService:WaitForChild("Modules") 
-- Reference to the 'Modules' folder inside ServerScriptService.
-- This folder is used to organize ModuleScripts for better structure and maintainability.


-- Table to hold ModuleScript instances to be managed.
-- Uncomment or add modules from ModuleFolder as needed for your project.
local modules = {
	-- ModuleFolder.RoomController,
	-- ModuleFolder.DamageController,
	-- Add your ModuleScripts here
}

-- Loads all modules in the 'modules' table by requiring them safely.
-- Uses pcall to catch errors during require and warns if any module fails to load.
function modules.LoadModules()
	for _, module in ipairs(modules) do
		if module:IsA("ModuleScript") then
			local success, result = pcall(require, module)
			if success then
				-- Module loaded successfully (optional debug print)
				-- print("Successfully loaded module:", module.Name)
			else
				-- Warn on failure to load the module with error details
				warn("Failed to load module:", module.Name, "\nError:", result)
			end
		end
	end
end

-- Checks if a module with the given name exists and can be required without error.
-- @param name string - The name of the module to check.
-- @return boolean or nil - Returns true if module loads successfully, nil if not found or error occurs.
function modules.HasModule(name)
	for _, module in ipairs(modules) do
		if module:IsA("ModuleScript") and module.Name == name then
			local success, _ = pcall(require, module)
			if success then
				return true
			else
				warn("Failed to find module:", module.Name, "\nError:", _)
				return nil
			end
		end
	end
	warn("Module not found:", name)
	return nil
end

-- Requires and returns the module with the specified name safely.
-- @param name string - The name of the module to require.
-- @return any or nil - Returns the module table if successful, nil otherwise.
function modules.RequireModule(name)
	for _, module in ipairs(modules) do
		if module:IsA("ModuleScript") and module.Name == name then
			local success, result = pcall(require, module)
			if success then
				return result
			else
				warn("Failed to require module:", module.Name, "\nError:", result)
				return nil
			end
		end
	end
	warn("Module not found:", name)
	return nil
end

return modules
