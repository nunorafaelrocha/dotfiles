
FROM ubuntu:20.04

LABEL maintainer="Nuno Rafael Rocha (nunorafaelrocha.com)"

ENV DEBIAN_FRONTEND=noninteractive

# Configure environment
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90nuno && \
	echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90nuno && \
	apt-get update && apt-get install -y \
		curl \
		locales \
		sudo \
	&& \
	locale-gen en_US.UTF-8 && \
	rm -rf /var/lib/apt/lists/* && \

	useradd --uid=1010 --user-group --create-home nuno && \
	echo 'nuno ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-nuno && \
	echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

ENV PATH=/home/nuno/bin:/home/nuno/.local/bin:$PATH \
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US:en \
	LC_ALL=en_US.UTF-8

USER nuno

# Match the default working directory
WORKDIR /home/nuno

COPY --chown=1010 . .dotfiles

RUN cd ~/.dotfiles && \
	CI=true ./bin/dot
