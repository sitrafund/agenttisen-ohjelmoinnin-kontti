FROM node:22

# Create directories with correct ownership before volumes are mounted
RUN mkdir -p /home/node/.vibe /home/node/.claude \
    && chown -R node:node /home/node/.vibe /home/node/.claude
