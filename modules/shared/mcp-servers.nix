# modules/shared/mcp-servers.nix
{ home }:
{
    # "community-server-llm-txt" = {
    #   runtime = "node";
    #   command = "npx";
    #   args = [ "@mcp-get-community/server-llm-txt" ];
    # };
    "memory" = {
      command = "npx";
      args = [ "@modelcontextprotocol/server-memory" ];
    };
    # "sqlite" = {
    #   command = "uv";
    #   args = [
    #     "--directory"
    #     "${home}/Repositories/servers/src/sqlite"
    #     "run"
    #     "mcp-server-sqlite"
    #     "--db-path"
    #     "${home}/Repositories/ai_workspace/algorithm_platform/data/algo.db"
    #   ];
    # };
    "docker-mcp" = {
      command = "uvx";
      args = [ "docker-mcp" ];
    };
    # "desktop-commander" = {
    #   command = "npx";
    #   args = [
    #     "-y"
    #     "${home}/Repositories/DesktopCommanderMCP/dist/index.js"
    #     "run"
    #     "desktop-commander"
    #     "--config"
    #     "\"{}\""
    #   ];
    # };
    # "playwright-mcp-server" = {
    #   command = "npx";
    #   args = [
    #     "-y"
    #     "@smithery/cli@latest"
    #     "run"
    #     "@executeautomation/playwright-mcp-server"
    #     "--config"
    #     "\"{}\""
    #   ];
    #   env = { DISPLAY = ":0"; };
    # };
    # "chroma" = {
    #   command = "uvx";
    #   args = [
    #     "chroma-mcp"
    #     "--client-type"
    #     "persistent"
    #     "--data-dir"
    #     "${home}/Repositories/chroma-db"
    #   ];
    # };

    # "zonos-tts-mcp" = {
    #   command = "node";
    #   args = [ "${home}/Repositories/Zonos-TTS-MCP-Linux/dist/server.js" ];
    # };
    "fetch" = {
      command = "uvx";
      args = [ "mcp-server-fetch" ];
    };
    # "arxiv-mcp-server" = {
    #   command = "uv";
    #   args = [
    #     "--directory"
    #     "${home}/Repositories/arxiv-mcp-server"
    #     "run"
    #     "arxiv-mcp-server"
    #     "--storage-path"
    #     "${home}/Documents/core_bot_instruction_concepts/arxiv-papers"
    #   ];
    # };
    # "neo4j" = {
    #   command = "uvx";
    #   args = [
    #     "mcp-neo4j-cypher"
    #     "--db-url"
    #     "bolt://localhost"
    #     "--username"
    #     "neo4j"
    #     "--password"
    #     "<your-db-password-goes-here>"
    #   ];
    # };
    # "package-version" = {
    #   command = "${home}/Repositories/mcp-package-version/bin/mcp-package-version";
    # };
    # "archon" = {
    #   command = "${home}/Repositories/Archon/venv/bin/python";
    #   args = [ "${home}/Repositories/Archon/mcp/mcp_server.py" ];
    # };
    # "serena" = {
    #   command = "uvx";
    #   args = [
    #     "--from"
    #     "uvx --from git+https://github.com/oraios/serena"
    #     "serena-mcp-server"
    #   ];
    # };
  }

