FROM node:22

# Asenna Claude Code
RUN npm install -g @anthropic-ai/claude-code@latest

# Luo hakemistot oikeilla omistusoikeuksilla ennen volyymien liittämistä.
RUN mkdir -p /home/node/.vibe /home/node/.claude \
    && chown -R node:node /home/node/.vibe /home/node/.claude
