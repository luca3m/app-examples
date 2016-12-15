FROM node:latest
WORKDIR /app
ADD package.json ./
RUN npm install
ENV SYSDIG_AGENT_CONF 'app_checks: [{name: node, check_module: prometheus, pattern: {comm: node}, conf: { url: "http://localhost:{port}/metrics" }}]'
ADD index.js ./
ENTRYPOINT [ "node", "index.js" ]
