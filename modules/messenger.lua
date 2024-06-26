local const = require("modules.const")
local tools = require("modules.tools")
local Messenger = {}

function Messenger:replyUserBets(target, options)
  local user_bets = options.user_bets
  local no = options.no
  local request_type = options.request_type
  local data_str = ""
  if user_bets and user_bets.count > 0 then
    local total_numbers = 0
    local total_bets = 0
    local bets_str = "\n"..string.rep("-", 58).."\n"
    for key, value in pairs(user_bets.numbers) do
      total_numbers = total_numbers + 1
      total_bets = total_bets + value
      bets_str = bets_str .. string.format(" %03d *%5d ",key,value) .. (total_numbers % 4 == 0 and "\n"..string.rep("-", 58).."\n" or " | ")
    end
    data_str = string.format([[You've placed %d bets that cover %d numbers on Round %s : ]],total_bets,total_numbers,no)..bets_str
  else
    data_str = string.format("You don't have any bets on aolotto Round %s.",no)
  end
  local message = {
    Target = target,
    Action = const.Actions.reply_user_bets,
    Data = (request_type == "json") and json.encode(user_bets.numbers) or data_str
  }
  ao.send(message)
end

function Messenger:forwardTo(target,msg)
  assert(target ~= nil,"no archiver process for your query.")
  local message = {
    Target = target,
    Data = msg.Data,
    User = msg.From,
  }
  local exclude = {["From-Module"] = true, ["Variant"] = true, ["Data-Protocol"] = true, ["Ref_"] = true}
  for key , val  in pairs(msg.Tags) do
    if not exclude[key] then
      message[key] = val
    end
  end
  ao.send(message)
end


function Messenger:sendWinNotice(no,winner,token)
  local rewards_str = tools:toBalanceValue(winner.rewards,token.Denomination)
  local data_str = string.format(
    "Congrats! You've won %s %s, %s of total rewards in aolotto round %s. The winning number is [%s], and you have %d bets matched.",
    rewards_str,
    token.Ticker,
    tostring(winner.percent*100).."%",
    tostring(no),
    tostring(winner.winning_number),
    winner.matched_bets
  )
  ao.send({
    Target=winner.id,
    Action=const.Actions.reward_notice,
    [const.Actions.reward_amount] = tostring(winner.rewards),
    [const.Actions.round] = tostring(no),
    [const.Actions.percent] = tostring(winner.percent),
    [const.Actions.matched_bets] = tostring(winner.matched_bets),
    [const.Actions.winning_number] = tostring(winner.winning_number),
    Data = const.Colors.yellow..data_str..const.Colors.reset
  })
end


function Messenger:sendError (err,target,code)
  ao.send({
    Target=target,
    Action="Error",
    Error = code or const.ErrorCode.default,
    Data=const.Colors.red..tostring(err)..const.Colors.reset
  })
end


function Messenger:sendRoundInfo (round,token,msg)

  local str = ""
  if request_type == "json" then
    str = json.encode(round)
  else
    
  local state_str = const.RoundStatus[round.status]
  local start_date_str = tools:timestampToDate(round.start_time,"%Y/%m/%d %H:%M")
  local end_date_str = tools:timestampToDate(round.end_time or round.start_time+round.duration,"%Y/%m/%d %H:%M")
  local total_prize = tools:toBalanceValue((round.base_rewards + (round.bets_amount or 0)),token.Denomination)
  local participants_str = tostring(round.participants or 0)
  local base_str = tostring(round.base_rewards)
  local bets_str = tostring(round.bets_amount or 0)
  local winners_str = tostring(0)
  if round.winners then
    winners_str = tostring(#round.winners)
  end
  local tips_str = round.status ~= 0 and string.format("Drawn on %s UTC, %s winners.",end_date_str,winners_str) or string.format("draw on %s UTC if bets >= %s",end_date_str,base_str)

  str=  string.format([[

  -----------------------------------------      
  aolotto Round %d - %s
  ----------------------------------------- 
  * Total Prize:       %s %s
  * Participants:      %s
  * Bets:              %s
  * Start at:          %s UTC
  ----------------------------------------- 
  %s

    ]],tonumber(round.no),state_str,total_prize,token.Ticker or "AO",participants_str,bets_str,start_date_str,tips_str)
  end
  local message = {
    Target = msg.User or msg.From,
    Data = str,
    Action = "Reply-RoundInfo",
  }
  ao.send(message)

end

return Messenger