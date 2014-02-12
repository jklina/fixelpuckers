def authorizes_the_action(args={})
  authorizee = args[:with]
  if authorizee
    expect(controller).to have_received(:authorize).with(authorizee)
  else
    expect(controller).to have_received(:authorize)
  end
end
