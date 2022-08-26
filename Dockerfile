FROM i386/alpine:3 as build

RUN apk add \
    binutils-mips-mti-elf \
    capstone-dev \
    g++ \
    git \
    make \
    pkgconfig

RUN git clone \
    --depth 1 \
    https://github.com/n64decomp/sm64.git \
    /sm64

WORKDIR /sm64/tools/ido5.3_recomp

# __assert is undefined
RUN sed -i \
    's/__assert(assertion, file, line);/fprintf(stderr, "Assertion failed: %s (%s line %d)\\n", assertion, file, line); exit(1);/' \
    libc_impl.c

RUN make all --jobs

### SECOND STAGE ###

FROM --platform=linux/386 i386/alpine:3 as run

COPY --from=build \
    /usr/bin/mips-mti-elf-objdump /usr/bin/mips-mti-elf-objdump

RUN mkdir -p /compiler/ido5.3

COPY --from=build \
    /sm64/tools/ido5.3_recomp/as1 \
    /sm64/tools/ido5.3_recomp/cc \
    /sm64/tools/ido5.3_recomp/cfe \
    /sm64/tools/ido5.3_recomp/copt \
    /sm64/tools/ido5.3_recomp/ugen \
    /sm64/tools/ido5.3_recomp/ujoin \
    /sm64/tools/ido5.3_recomp/umerge \
    /sm64/tools/ido5.3_recomp/uopt \
    /sm64/tools/ido5.3_recomp/usplit \
    /sm64/tools/ido5.3_recomp/err.english.cc \
    /compiler/ido5.3/

COPY example/*.c /input/

COPY entrypoint.sh /

CMD ["/entrypoint.sh"]
