defmodule F15Test do
  use ExUnit.Case
  alias Modbus.Request
  alias Modbus.Response
  alias Modbus.Model

  test "Write 011 to Multiple Digital Outputs" do
    state0 = %{ 0x50=>%{
      {:do, 0x5152}=>1, {:do, 0x5153}=>0, {:do, 0x5154}=>0,
    } }
    state1 = %{ 0x50=>%{
      {:do, 0x5152}=>0, {:do, 0x5153}=>1, {:do, 0x5154}=>1,
    } }
    val0 = [0,1,1]
    cmd0 = {:wdo, 0x50, 0x5152, val0}
    req0 = <<0x50, 15, 0x51, 0x52, 0, 3, 1, 0x06>>
    resp0 = <<0x50, 15, 0x51, 0x52, 0, 3>>
    ^req0 = Request.pack(cmd0)
    {^cmd0, <<>>} = Request.parse(req0)
    {^state1, nil} = Model.apply(state0, cmd0)
    ^resp0 = Response.pack(cmd0, nil)
    {nil, <<>>} = Response.parse(cmd0, resp0)
  end

  test "Write 0011 1100 0101 to Multiple Digital Outputs" do
    state0 = %{ 0x50=>%{
      {:do, 0x5152}=>1, {:do, 0x5153}=>1, {:do, 0x5154}=>0, {:do, 0x5155}=>0,
      {:do, 0x5156}=>0, {:do, 0x5157}=>0, {:do, 0x5158}=>1, {:do, 0x5159}=>1,
      {:do, 0x515A}=>1, {:do, 0x515B}=>0, {:do, 0x515C}=>1, {:do, 0x515D}=>0,
    } }
    state1 = %{ 0x50=>%{
      {:do, 0x5152}=>0, {:do, 0x5153}=>0, {:do, 0x5154}=>1, {:do, 0x5155}=>1,
      {:do, 0x5156}=>1, {:do, 0x5157}=>1, {:do, 0x5158}=>0, {:do, 0x5159}=>0,
      {:do, 0x515A}=>0, {:do, 0x515B}=>1, {:do, 0x515C}=>0, {:do, 0x515D}=>1,
    } }
    val0 = [0,0,1,1, 1,1,0,0, 0,1,0,1]
    cmd0 = {:wdo, 0x50, 0x5152, val0}
    req0 = <<0x50, 15, 0x51, 0x52, 0, 12, 2, 0x3C, 0x0A>>
    resp0 = <<0x50, 15, 0x51, 0x52, 0, 12>>
    ^req0 = Request.pack(cmd0)
    {^cmd0, <<>>} = Request.parse(req0)
    {^state1, nil} = Model.apply(state0, cmd0)
    ^resp0 = Response.pack(cmd0, nil)
    {nil, <<>>} = Response.parse(cmd0, resp0)
  end

end