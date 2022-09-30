echo "Downloading Cecil"
if [ -z $CECIL_VERSION ]; then
  curl -sSOL https://cecil.app/cecil.phar
else
  if [ $(curl -LI https://cecil.app/download/$CECIL_VERSION/cecil.phar -o /dev/null -w '%{http_code}\n' -s) == '200' ]; then
    curl -sSOL https://cecil.app/download/$CECIL_VERSION/cecil.phar
  else
    echo "Can't download version $CECIL_VERSION. Trying from GitHub's release.";
    if [ $(curl -LI https://github.com/Cecilapp/Cecil/releases/download/$CECIL_VERSION/cecil.phar -o /dev/null -w '%{http_code}\n' -s) != '200' ]; then
    echo "Can't download version $CECIL_VERSION from GitHub"; exit 1
    fi
    curl -sSOL https://github.com/Cecilapp/Cecil/releases/download/$CECIL_VERSION/cecil.phar
  fi
fi
php cecil.phar --version

if [[ $CECIL_ENV == "production" ]]; then
  php cecil.phar build -v --baseurl=$URL --postprocess
else
  php cecil.phar build -vv --baseurl=$DEPLOY_PRIME_URL --drafts --config=config/dev.yml || { sleep 30; false; }
fi

# build success? can deploy?
if [ $? = 0 ]; then echo "Finished Cecil build"; exit 0; fi

echo "Interrupted Cecil build"; exit 1
