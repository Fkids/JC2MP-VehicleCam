-- Scripted by Fkids ( http://fkids.net )

class 'VehicleCam'

function VehicleCam:__init()

    self.mode = 1
    self.modeCount = 8
    self.freezeCam = false

    Events:Subscribe("CalcView", self, self.onCalcView)
    Events:Subscribe("LocalPlayerInput", self, self.onLocalPlayerInput)
    Events:Subscribe("KeyUp", self, self.onKeyUp)

end

function VehicleCam:onCalcView()

    if not LocalPlayer:InVehicle() then return end

    -- Default
    if self.mode == 1 then
        self.freezeCam = false
        return
    end

    local vehicle = LocalPlayer:GetVehicle()
    if not IsValid(vehicle) then return end

    -- Closer
    if self.mode == 2 then
        Camera:SetPosition(vehicle:GetPosition() + Camera:GetAngle() * Vector3(0, 2, 4))
        self.freezeCam = false
    end

    -- First Person
    if self.mode == 3 then
        Camera:SetPosition(LocalPlayer:GetBonePosition("ragdoll_Head") + Camera:GetAngle() * Vector3(0, 0.25, 0.2))
        self.freezeCam = false
    end

    -- Hood
    if self.mode == 4 then
        Camera:SetPosition(vehicle:GetPosition() + Camera:GetAngle() * Vector3(0, 2, -4))
        self.freezeCam = true
    end

    -- In Front
    if self.mode == 5 then
        Camera:SetPosition(vehicle:GetPosition() + Camera:GetAngle() * Vector3(0, 1.2, -4))
        self.freezeCam = true
    end

    -- Top View
    if self.mode == 6 then
        Camera:SetPosition(vehicle:GetPosition() + Vector3(0, 40, 0))
        Camera:SetAngle(Angle(vehicle:GetAngle().yaw, math.pi*1.51, 0))
        self.freezeCam = false
    end

    -- Far Behind
    if self.mode == 7 then
        Camera:SetPosition(vehicle:GetPosition() + Camera:GetAngle() * Vector3(0, 3, 20))
        self.freezeCam = false
    end

    -- Behind
    if self.mode == 8 then
        Camera:SetPosition(vehicle:GetPosition() + Camera:GetAngle() * Vector3(0, 2.5, 10))
        self.freezeCam = false
    end

end

function VehicleCam:onLocalPlayerInput(args)

    if not LocalPlayer:InVehicle() then return end

    if args.input == Action.VehicleCam then return false end

    if self.freezeCam then

        if args.input == Action.LookUp or
           args.input == Action.LookDown or
           args.input == Action.LookLeft or
           args.input == Action.LookRight then

            return false

        end

    end

end

function VehicleCam:onKeyUp(args)

    if not LocalPlayer:InVehicle() then return end
    if args.key ~= string.byte("C") then return end

    self.mode = self.mode + 1

    if self.mode > self.modeCount then
        self.mode = 1
    end

end

VehicleCam = VehicleCam()
