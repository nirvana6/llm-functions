#!/usr/bin/env bash
set -e

# @describe Perform a web search using Perplexity API to get up-to-date information or additional context.
# Use this when you need current information or feel a search could provide a better answer.

# @option --query! The query to search for.

# @env METASO_API_KEY! The api key
# @env LLM_OUTPUT=/dev/stdout The output path

main() {
#     curl -fsS -X POST https://api.perplexity.ai/chat/completions \
#      -H "authorization: Bearer $PERPLEXITY_API_KEY" \
#      -H "accept: application/json" \
#      -H "content-type: application/json" \
#      --data '
# {
#   "model": "'"$PERPLEXITY_WEB_SEARCH_MODEL"'",
#   "messages": [
#     {
#       "role": "user",
#       "content": "'"$argc_query"'"
#     }
#   ]
# }
# '  | \
#         jq -r '.choices[0].message.content' \
#         >> "$LLM_OUTPUT"

curl --location 'https://metaso.cn/api/v1/search' \
  --silent \
  --header "Authorization: Bearer $METASO_API_KEY" \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data '{"q":"'"$argc_query"'","scope":"webpage","includeSummary":false,"size":"1","includeRawContent":true,"conciseSnippet":false}' | \
        jq -r '.webpages[0].content' \
        >> "$LLM_OUTPUT"

}

eval "$(argc --argc-eval "$0" "$@")"
