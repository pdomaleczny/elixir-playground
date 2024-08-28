defmodule WebCrawlerTest do
  use ExUnit.Case, async: true
  import Mock

  @html_body """
  <html>
    <body>
      <a href="https://example.com/page1">Page 1</a>
      <a href="https://example.com/page2">Page 2</a>
    </body>
  </html>
  """

  describe "crawl/1" do
    test "returns all links from the page" do
      with_mock HTTPoison,
        get: fn _url -> {:ok, %HTTPoison.Response{status_code: 200, body: @html_body}} end do
        links = WebCrawler.crawl("https://example.com")

        assert links == ["https://example.com/page1", "https://example.com/page2"]
      end
    end

    test "returns an empty links list when other than 200 status code is returned" do
      with_mock HTTPoison,
        get: fn _url -> {:ok, %HTTPoison.Response{status_code: 203}} end do
        links = WebCrawler.crawl("https://example.com")

        assert links == []
      end
    end

    test "returns an empty list when there are no links in the html" do
      with_mock HTTPoison,
        get: fn _url ->
          {:ok, %HTTPoison.Response{status_code: 200, body: "<html><body></body></html>"}}
        end do
        links = WebCrawler.crawl("https://example.com")

        assert links == []
      end
    end

    test "raise an error when there is error from HTTPoison" do
      with_mock HTTPoison,
        get: fn _url -> {:error, %HTTPoison.Error{reason: "Reason"}} end do
        assert_raise RuntimeError, "Failed to fetch page: Reason", fn ->
          WebCrawler.crawl("https://example.com")
        end
      end
    end
  end
end
