class BadEvnrionmentError < RuntimeError
  def to_s
    "Specify trajectory API environment variables : TRAJECTORY_API_KEY and TRAJECTORY_ACCOUNT_KEYWORD"
  end
end
