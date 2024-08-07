local Const = {} 
Const.Actions = {
  lotto_notice = "Lotto-Notice",
  finish = "Finish",
  archive_round = "Archive-Round",
  round_spawned = "Round-Spawned",
  reply_rounds ="Reply-Rounds",
  bets = "Bets",
  reply_user_bets = "Reply-UserBets",
  reply_user_info = "Reply-UserInfo",
  user_info = "UserInfo",
  claim = "Claim",
  OP_withdraw = "OP_withdraw",
  x_transfer_type = "X-Transfer-Type",
  x_faucet_order = 'X-Faucet-Order',
  shoot = "Shoot",
  change_shooter = "ChangeShooter",
  change_archiver = "ChangeArchiver",
  round_archived = "Round-Archived",
  pause_round = "Pause-Round",
  round_restart = "Restart-Round",
  round_start = "Start-Round",
  refund = "Refund",
  x_amount = "X-Amount",
  x_tax = "X-Tax",
  x_pushed_for = "X-Pushed-For",
  x_numbers = "X-Numbers",
  request_type = "RequestType",
  rounds = "Rounds",
  reject = "Reject",
  get_round_info = "GetRoundInfo",
  reward_notice = "Reward-Notice",
  reward_amount = "Reward-Amount",
  round = "Round",
  winning_number = "Winning-Number",
  matched_bets = "Matched-Bets",
  percent = "Percent",
  change_archiver = "Change-Archiver",
  x_user = "X-User",
  round_notice = "Round-Notice",
  claim_notice = "Claim-Notice",
  draw="Draw",
  add_buff = "Add-Buff",
  sponsor = "Sponsor",
  info = "Info",
  reply_info="Reply-Info",
  winners = "Winners",
  reply_winners = "Reply-Winners",
  mint_rewards = "Mint-Rewards",
  minted = "Minted"
}

Const.RoundStatus = {
  [-1] = "Canceled",
  [0] = "Ongoing",
  [1] = "Ended",
  [2] = "Paused"
}
Const.ErrorCode = {
  default = "400",
  transfer_error = "Transfer-Error"
}

Const.Colors = {
  red = "\27[31m",
  green = "\27[32m",
  blue = "\27[34m",
  yellow = "\27[33m",
  reset = "\27[0m"
}



return Const