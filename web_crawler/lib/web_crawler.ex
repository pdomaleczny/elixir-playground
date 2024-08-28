defmodule WebCrawler do
  @moduledoc """
  A simple web crawler that fetches a page and extracts all links.
  """

  alias Floki

  def crawl(url) do
    url
    |> fetch_page()
    |> extract_links()
  end

  defp fetch_page(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body}} ->
        body

      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        IO.puts("Failed to fetch page. Status code: #{status_code}")
        []

      {:error, %HTTPoison.Error{reason: reason}} ->
        raise "Failed to fetch page: #{reason}"
    end
  end

  defp extract_links(nil) do
    []
  end

  defp extract_links(html) do
    {:ok, html} = Floki.parse_document(html)

    html
    |> Floki.find("a[href]")
    |> Floki.attribute("href")
  end
end
