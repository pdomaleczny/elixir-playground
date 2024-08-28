# Web Crawler

## Overview

This project implements a simple web crawler in Elixir. The crawler fetches a web page from a given URL, extracts all the hyperlinks (`<a href="...">`), and returns a list of these links. This exercise demonstrates how to handle HTTP requests, parse HTML, and work with basic functional programming concepts in Elixir.

## Features

- Fetches HTML content from a specified URL.
- Extracts all hyperlinks (`<a href="...">`) from the HTML content.
- Handles various HTTP responses and errors gracefully.
- Supports both absolute and relative URLs.


## Prerequisites

- [Elixir](https://elixir-lang.org/install.html) (version 1.12 or later recommended)
- [HTTPoison](https://github.com/edgurgel/httpoison) (for making HTTP requests)
- [Floki](https://github.com/philss/floki) (for parsing HTML)

## Installation

1. **Clone the Repository**

   ```bash
   git clone <repository-url>
   cd web_crawler
  ```
2. **Install Dependencies**

   ```bash
   mix deps.get
   ```

## Usage

To use the web crawler, you can run the `WebCrawler.crawl/1` function with a URL as an argument. Here's an example:

```elixir
iex> WebCrawler.crawl("https://google.com")
["https://about.google", "https://store.google.com"]
```
