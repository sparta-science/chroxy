defmodule Chroxy.ChromeServerTest do
  use ExUnit.Case, async: true

  describe "opts" do
    import Chroxy.ChromeServer, only: [opts: 2]

    test "uses defaults if there are no overrides" do
      assert Keyword.get(opts([], []), :chrome_port) == 9222
    end

    test "uses module config overrides if provided" do
      assert Keyword.get(opts([chrome_port: 1111], []), :chrome_port) == 1111
    end

    test "uses init args overrides if provided" do
      assert Keyword.get(opts([], [chrome_port: 2222]), :chrome_port) == 2222
    end

    test "uses init args overrides if both module config and init args are provided" do
      assert Keyword.get(opts([chrome_port: 1111], [chrome_port: 2222]), :chrome_port) == 2222
    end

    test "'headless' option replaces a chrome flag instead of being merged into opts" do
      assert Keyword.get(opts([headless: false], []), :headless) == nil
    end

    test "'headless' defaults to true" do
      assert "--headless" in Keyword.get(opts([], []), :chrome_flags)
    end

    test "'headless' can be set to true" do
      assert "--headless" in Keyword.get(opts([], [headless: true]), :chrome_flags)
    end

    test "'headless' can be set to false" do
      refute "--headless" in Keyword.get(opts([], [headless: false]), :chrome_flags)
    end
  end
end