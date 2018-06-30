FROM node:6-alpine
        
        COPY ./ /undefined/
        RUN npm --prefix /undefined/ install
        
        CMD npm --prefix /undefined/ start
        