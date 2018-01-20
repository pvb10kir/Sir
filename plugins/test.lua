local action = function(msg, blocks, ln)
if db:get("reg:"..msg.from.id) == 'waiting' and blocks[1] then
	local hash = "reg:"..msg.from.id
          db:set(hash,blocks[1])
	api.sendMessage(msg.chat.id, '> *Your Password Has Been Saved! | پسورد شما ذخیره شد.*', true)
			end
   end
return {
	action = action,
	triggers = {
	    '^/(register)$',
    }
}
