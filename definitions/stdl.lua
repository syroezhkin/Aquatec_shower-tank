---@meta

---@alias Solid table

Solid = {}

function Solid:Shift(x, y, z) end

function SetDetailedGeometry(geometry) end

function SetSymbolicGeometry(geometry) end

function SetSymbolGeometry(geometry) end

---@return Solid
function CreateBlock(xSize, ySize, zSize) end

---@return Solid
function CreateRectangularPyramid(width, depth, height) end

---@return Solid
function CreateRightCircularCylinder(radius, height) end

---@return Solid
function Unite(solids) end

Style = {}

---@return table
function Style.GetParameterValues() end

---@return table
function Style.GetParameterGroup(groupName) end

ModelGeometry = {}
