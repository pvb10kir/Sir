local function do_keyboard_register()
    local keyboard = {}
    keyboard.inline_keyboard = {
		{
    					{text = '🔙', callback_data = '!home'},
},
    }
    return keyboard
end
local function do_keyboard_login()
    local keyboard = {}
    keyboard.inline_keyboard = {
	    {
	    {text = '🔙', callback_data = '!home'}
 }      
    }
    return keyboard
end

local function do_keyboard_private()
    local keyboard = {}
    keyboard.inline_keyboard = {
    	{
    		{text = '📍Register📍', callback_data = '!register'},
	    },
		{
	        {text = '📍Login📍', callback_data = '!login'},
        },
    }
    return keyboard
end
local action = function(msg, blocks, ln)
    if blocks[1] == 'start' or blocks[1] == 'help' then
        db:hset('bot:users', msg.from.id, 'xx')
        db:hincrby('bot:general', 'users', 1)
        if msg.chat.type == 'private' then
            local message = [[HI, Choose.]]
            local keyboard = do_keyboard_private()
            api.sendKeyboard(msg.from.id, message, keyboard, true)
            end
        return
    end
    if msg.cb then
        local query = blocks[1]
        local msg_id = msg.message_id
        local text
		if query == 'login' then
            local text = [[*Send Me Your Password For Login.*]]
            local keyboard = do_keyboard_login()
        api.editMessageText(msg.chat.id, msg_id, text, keyboard, true)
end
		if query == 'register' then
        api.sendMessage(msg.chat.id, '> *Hi, Please set password for your account | لطفا یه پسورد برای اکانت خود انتخاب کنید و برای من ارسال کنید.*', true)
	db:set("reg:"..msg.from.id, 'waiting')
		end
			if db:get("reg:"..msg.from.id) == 'waiting' and blocks[1] then
	local hash = "reg:"..msg.from.id
          db:set(hash,blocks[1])
	api.sendMessage(msg.chat.id, '> *Your Password Has Been Saved! | پسورد شما ذخیره شد.*', true)
			end
if query == 'home' then
            local text = [[📍شما به صفحه اول برگشتید📍
📌یک دکمه را انتخاب کنید🔥
]]
            local keyboard = do_keyboard_private()
        api.editMessageText(msg.chat.id, msg_id, text, keyboard, true)
end
    end

end

return {
	action = action,
	triggers = {
	    '^/(start)@Sphero_Bot$',
	    '^/(start)$',
	    '^/(help)$',
	    '^###cb:!(home)',
	    '^###cb:!(register)',
            '^###cb:!(login)',

    }
}
