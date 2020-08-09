# general rule for "make digests"
# 
# include this file after the rule "all:"
#

sha1sum := $(shell which sha1sum 2>/dev/null || which gsha1sum 2>/dev/null)
sha256sum := $(shell which sha256sum 2>/dev/null || which gsha256sum 2>/dev/null)
md5sum := $(shell which md5sum 2>/dev/null || which gmd5sum 2>/dev/null || which md5 2>/dev/null)

$(DIGESTS_FILE): download
	@$(MSG) "Generating digests for $(NAME)"
	@rm -f $@ && touch -f $@
	@for type in SHA1 SHA256 MD5; do \
	  case $$type in \
	    SHA1)     tool=sha1sum ;; \
	    SHA256)   tool=sha256sum ;; \
	    MD5)      tool=md5sum ;; \
	  esac ; \
	  echo "$(LOCAL_FILE) $$type `$$tool $(DIST_FILE) | cut -d\" \" -f1`" >> $@ ; \
	done
