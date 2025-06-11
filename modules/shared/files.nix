{ pkgs, config, lib, ... }:

let
  githubPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAao6hYRda8Dc88DgWHblVFV/HFCcj6kJuDWq7oqt7Aq";
  githubPublicSigningKey = ''
    -----BEGIN PGP PUBLIC KEY BLOCK-----

    mQGNBGNHB2YBDADNAoEzFeTEn/84dnrZKL+yeOq0m07cMFwQLiiylstJj0OxOJI3
    0frjNsijIOTDhtrrYNr+vkc7Bsf2P4aI+FmkrBfKfY4oA1GBjyb823ran99Fnfy9
    r7n8FM7X/6E7BG8cYawcLmFW5A8++h25tqoEoSw9y0ENTC/tP5TSZc7ypUJ2qKs5
    nfvnCYs7P2avLtJrElZiwnkjsMADyj6CtGjTOAGi5LypsDX/9oqzAMOJH6eD2829
    irhZ9zLg1HLkaFN4FApdmeHhCyM8e3d4yXMYAfjQ52RFFci4cf+cVp2ijgX+FZpp
    7aBz9Fxqfb34kCzPktXh6dROmlFg9Of6jJmcGBxDr7vuo6FciFyQUjSe1BsMIjrb
    WC5N4wb/nWGUPaWKtN7BTUNcTGy5xAk4i03xWacamqaLbMiqKN9BHoGT8D7BmqQo
    toh1yhoVpuKkwOT66NM7vfCH5N3s0zEsAI8RHHSqNBWincx5yyQoqveeYPn9EOJs
    f7MnPR2mgvBuvN8AEQEAAbQgRHVzdGluIEx5b25zIDxkdXN0aW5AZGx5b25zLmRl
    dj6JAdEEEwEIADsWIQSRE59mup65UqK9X4TZWq5A0U5jswUCY0cHZgIbAwULCQgH
    AgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCRDZWq5A0U5js1kxDACQZAP6orX+4tWO
    dk+9gNtKlq+oDYwFg6ITl8NyurCzlLl3OhhKuCIhCd6FeBhcmCO2WhupKgkjB2ij
    HCUMlf4Qs6gLHgU+MvvtwIJYycil0q10FATRv2jH73txk4hCUcSgy4MNT6MsjOgB
    innZgFYte08a54SHxmRN5RbXCeddkcDM+kdeMsEu24kczxbNHjkJGV2IpyWYIH5m
    Y+VPySt6url4UQZhtF00weV21Nl3yao3+lqv+f/ML0EFJTyri6TzH9E9Owk/iszz
    hhFoofPRvvqE4VkvnwUmHidzWa9x3XyuzwBFRTBgE6ZfsDDclRUmhNsxRtjwSW0k
    FmjUDmCgWjlGY5iJneJ32n5ccwWc5MBLztHb8u52eg74f84iMr0wSYctaWDb++nl
    pB64jEJobZWXJf74zHkIb51TfhSAqGGX6gHxQ/bsZ3iv8zYXWkjTsq4dgtbylWVA
    suhaqxTG8/WjCzFLCQebME7x3ChEJFNXM40LMi3pBLPTge0UCUK5AY0EY0cHZgEM
    ANqEI67q5MRDcGnX0gKeKgRcqMFlJq0Lpm1YfqjVBiw4PEwQBJ8cW3nZaA+fTZTJ
    1X31ti+0HkcYbnQzsXDAFNo+iaeJ3JDMgIK5+tayCpTFnjec47iniP2wIaPfdaGx
    zqMEp9JXAJuwpjT5qIqIyx9Qh6fvteittz2FKycla3mnrAeswyFLM0LsjkUi7g0O
    FLcmOiCEmcQQzL9cKLPm2p+tnwudId5FdeQtDXW9wYN+kEu+UMOGFVzrCCtWMoee
    NNna9ZPw/5Pjk2RbMSykvGvImcUQeKtheyV/xk8i9NUdTQk6hctK7dGm45QlvroQ
    95cHdEKUdJRgzpN8TG+LWPR8+FUFATlSNFCTPNJiaVY1Jyn74Prfg/V7TkFNZbSP
    KRMYQy9BfUxC1uGsy/a5NlfPAJ+uU7up+NHD9GCl7QtmJGsqdkac8VCSpUt+dgCI
    ILlIHbeWsMBsMZUNggOHZt+G8xE13mo2yr6ylJ87sRA0iu9Yk2BgQ1zkiLBPwZ+y
    UQARAQABiQG2BBgBCAAgFiEEkROfZrqeuVKivV+E2VquQNFOY7MFAmNHB2YCGwwA
    CgkQ2VquQNFOY7NLjQwAuCZYL+I5QwJ4nTFRRtkJYi55BvLbEuyVnYwbkHpHksg6
    Nxh1gbykEdFAafJAVDCwU/ov+GA7RLVRS0TtnU7DBKUmzbO6MvFusjs8190PwLKP
    9Eb2gWgTkECyd0WC3HMvfTBk96koidpxGLDal5P7B8DoanaqcuEf5QAWawT66lW/
    sOYmrDOlEisV14/Mk/XgdOO/X/BKDXoGlTOtsiWFw50sBzjg9nKQUkaSzgU1HB5g
    TSZu6Wi4OtVdTMxT2ryOLj78YAQ3eBtfDak2in2J6bOY2i9d+vP5TKik4DeZypNQ
    iLgAKJ5+2NRlCbnci1bmay21Ke1PIZiUTe82lCoS4CoEJzKU89NtHSU64M7FEjBS
    5yYtMrs+ko+INWYG9aEj7rs4grpQMP9NF5AxfDuq77+Ca7Vg9pTkI1DYj1D91mWR
    J/pMd3YqlIkZ4JBN489FZ1qqRV6RuKko/qyqvvQ5+ziqrh+QjluJU4qI60znX/LI
    1USIqi8ymF08Ak+cIhyO
    =WFfO
    -----END PGP PUBLIC KEY BLOCK-----
  '';

  cheatsheetPath = ./config/cheat/cheatsheets/system;
  cheatsheetFiles = builtins.readDir cheatsheetPath;
  mkCheatsheet = name: type: lib.nameValuePair ".config/cheat/cheatsheets/system/${name}" {
    source = cheatsheetPath + "/${name}";
  };
  cheatsheets = lib.mapAttrs' mkCheatsheet (lib.filterAttrs (n: v: v == "regular") cheatsheetFiles);

in

{

  ".ssh/id_github.pub" = {
    text = githubPublicKey;
  };

  ".ssh/pgp_github.pub" = {
    text = githubPublicSigningKey;
  };
  ".config/nvim" = {
    source = ./config/nvim;
    recursive = true;
  };
  ".config/op-setup.sh" = {
    text = ''
    #!/usr/bin/env bash
    #
    # Fetch your OpenAI API key from 1Password and export it
    OPENAI_API_KEY="$(op item get kn5awwfh4yl7pyishgagqpjore --field "api key" --reveal)"
    export OPENAI_API_KEY

    TAVILY_API_KEY="$(op item get qp6kvptfur6gratnvshzna2ev4 --field "credential" --reveal)"
    export TAVILY_API_KEY
    '';
  };

  ".config/cheat/conf.yml" = {
    text = ''
---
# The editor to use with 'cheat -e <sheet>'. Defaults to $EDITOR or $VISUAL.
editor: nvim

# Should 'cheat' always colorize output?
colorize: false

# Which 'chroma' colorscheme should be applied to the output?
# Options are available here:
#   https://github.com/alecthomas/chroma/tree/master/styles
style: monokai

# Which 'chroma' "formatter" should be applied?
# One of: "terminal", "terminal256", "terminal16m"
formatter: terminal256

# Through which pager should output be piped?
# 'less -FRX' is recommended on Unix systems
# 'more' is recommended on Windows
pager: less -R

# Cheatpaths are paths at which cheatsheets are available on your local
# filesystem.
#
# It is useful to sort cheatsheets into different cheatpaths for organizational
# purposes. For example, you might want one cheatpath for community
# cheatsheets, one for personal cheatsheets, one for cheatsheets pertaining to
# your day job, one for code snippets, etc.
#
# Cheatpaths are scoped, such that more "local" cheatpaths take priority over
# more "global" cheatpaths. (The most global cheatpath is listed first in this
# file; the most local is listed last.) For example, if there is a 'tar'
# cheatsheet on both global and local paths, you'll be presented with the local
# one by default. ('cheat -p' can be used to view cheatsheets from alternative
# cheatpaths.)
#
# Cheatpaths can also be tagged as "read only". This instructs cheat not to
# automatically create cheatsheets on a read-only cheatpath. Instead, when you
# would like to edit a read-only cheatsheet using 'cheat -e', cheat will
# perform a copy-on-write of that cheatsheet from a read-only cheatpath to a
# writeable cheatpath.
#
# This is very useful when you would like to maintain, for example, a
# "pristine" repository of community cheatsheets on one cheatpath, and an
# editable personal reponsity of cheatsheets on another cheatpath.
#
# Cheatpaths can be also configured to automatically apply tags to cheatsheets
# on certain paths, which can be useful for querying purposes.
# Example: 'cheat -t work jenkins'.
#
# Community cheatsheets must be installed separately, though you may have
# downloaded them automatically when installing 'cheat'. If not, you may
# download them here:
#
# https://github.com/cheat/cheatsheets
cheatpaths:
  # Cheatpath properties mean the following:
  #   'name': the name of the cheatpath (view with 'cheat -d', filter with 'cheat -p')
  #   'path': the filesystem path of the cheatsheet directory (view with 'cheat -d')
  #   'tags': tags that should be automatically applied to sheets on this path
  #   'readonly': shall user-created ('cheat -e') cheatsheets be saved here?
  - name: community
    path: /Users/pjones/.config/cheat/cheatsheets/community
    tags: [ community ]
    readonly: true

  - name: system
    path: /Users/pjones/.config/cheat/cheatsheets/system
    tags: [ system ]
    readonly: true

  # If you have personalized cheatsheets, list them last. They will take
  # precedence over the more global cheatsheets.
  - name: personal
    path: /Users/pjones/.config/cheat/cheatsheets/personal
    tags: [ personal ]
    readonly: false

  # While it requires no configuration here, it's also worth noting that
  # cheat will automatically append directories named '.cheat' within the
  # current working directory to the 'cheatpath'. This can be very useful if
  # you'd like to closely associate cheatsheets with, for example, a directory
  # containing source code.
  #
  # Such "directory-scoped" cheatsheets will be treated as the most "local"
  # cheatsheets, and will override less "local" cheatsheets. Similarly,
  # directory-scoped cheatsheets will always be editable ('readonly: false').
    '';
  };
} // cheatsheets
