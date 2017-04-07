FROM centos:centos6
MAINTAINER Yoshiaki Yoshida <y.yoshida22@gmail.com>

RUN yum install -y \
    epel-release \
    openssl-devel \
    readline-devel\
    zlib-devel \
    wget \
    curl \
    git \
    vim \
    bzip2 \
    tar \
  && yum groupinstall 'Development Tools' -y \
  && yum clean all

RUN git clone git://github.com/rbenv/rbenv.git /usr/local/rbenv \
  && git clone git://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
  && /usr/local/rbenv/plugins/ruby-build/install.sh
ENV PATH /usr/local/rbenv/bin:${PATH}
ENV RBENV_ROOT /usr/local/rbenv

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
  && echo 'export PATH=/usr/local/rbenv/bin:${PATH}' >> /etc/profile.d/rbenv.sh \
  && echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc \
  && echo 'export PATH=/usr/local/rbenv/bin:${PATH}' >> /root/.bashrc \
  && echo 'eval "$(rbenv init -)"' >> /root/.bashrc

ENV CONFIGURE_OPTS --disable-install-doc
ENV PATH /usr/local/rbenv/bin:/usr/local/rbenv/shims:${PATH}

RUN eval "$(rbenv init -)"; rbenv install 2.4.1 \
  && eval "$(rbenv init -)"; rbenv global 2.4.1 \
  && eval "$(rbenv init -)"; gem update --system \
  && eval "$(rbenv init -)"; gem install bundler
