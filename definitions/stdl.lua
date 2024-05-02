---@meta

---@alias Solid table
Solid = {}

---@alias Point3D table
Point3D = {}

---@alias Vector3D table
Vector3D = {}

---@alias Axis3D table
Axis3D = {}

function Solid:Shift(x, y, z) end

function SetDetailedGeometry(geometry) end

function SetSymbolicGeometry(geometry) end

function SetSymbolGeometry(geometry) end

---@alias Placement3D Placement3D
function Placement3D(point, z_axis_direction, x_axis_direction) end

---@return Solid
function CreateBlock(xSize, ySize, zSize) end

---@param width number
---@param depth number
---@param height number
---@param placement? Placement3D
---@return Solid
function CreateRectangularPyramid(width, depth, height, placement) end

---@return Solid
function CreateRightCircularCylinder(radius, height) end

---@return Solid
function Unite(solids) end

---@return Solid
function Subtract(solid1, solid2) end

---@return Solid
function Intersect(solid1, solid2) end

Style = {}

---@return table
function Style.GetParameterValues() end

---@return table
function Style.GetParameterGroup(groupName) end

ModelGeometry = {}
