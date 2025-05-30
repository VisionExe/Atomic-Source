-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Atomicals Interface [ Money Code ]    | Created by discord.gg/getsades & ATMC Community     | Unauthorized use or redistribution is strictly prohibited                                         --
-- Version 4.0.1 - Open Source           | Last updated: 2025 · No public changelogs           | This software is protected under copyright law. Legal action may be taken against violators       --
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local player_gui: Instance = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local utils: table            = {}
local latest_earnings: number = 0

function utils.clean_money(text: string): number | string?

    if typeof(text) == "string" then

        local cleaned_string = text:gsub("RP. ", ""):gsub(",", ""):gsub("%.", ""):gsub("+", ""):gsub(" ", "")
        return tonumber(cleaned_string)

    end

    return "Invalid Type! : Expected \"string\""

end

function utils.format_comma(text: number): string

    if typeof(text) == "number" then

        local format = string.format("%.0f", text):reverse():gsub("(%d%d%d)", "%1,"):reverse()

        if format:sub(1,1) == "," then

            format = format:sub(2)

        end
        return format
        
    end

    return "Invalid type, expected number."

end

function utils.start_money_listener(): nil

    local money_text: Instance = player_gui.Main.Container.Hub.CashFrame.TextLabel

    money_text:GetPropertyChangedSignal("Text"):Connect(function()

        local earned_money: number = utils.clean_money(money_text.Text)

        if tonumber(earned_money) and tonumber(earned_money) <= 300000000 then

            latest_earnings = earned_money

        end

    end)
    
end

function utils.get_current_money(clean_money: boolean): number | string

    local money_value: string = player_gui.Main.Container.Hub.CashFrame.Frame.TextLabel.Text

    if clean_money then

        return utils.clean_money(money_value)

    end

    return money_value

end

function utils.get_latest_earnings(clean_money: boolean): number | string

    local latest_value: string = player_gui.Main.Container.Hub.CashFrame.TextLabel.Text

    if clean_money then

        return utils.clean_money(latest_value)

    end

    return latest_value

end

function utils.get_total_earnings(clean_money: boolean): number | string

    local total_value: string = player_gui.PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value.Text

    if clean_money then

        return utils.clean_money(total_value)

    end

    return total_value

end

function utils.check_latest_earnings(): number

    return latest_earnings

end

function utils.check_gamepass(): boolean

    local gamepass_frame: boolean = player_gui.Main.Container.Marketplace.Gamepass.JobEarnings.Frame.Owned.Visible
    return gamepass_frame

end

return utils
