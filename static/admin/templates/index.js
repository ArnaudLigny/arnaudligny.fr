//import CMS from 'netlify-cms-app';
//import { fr } from 'netlify-cms-locales';
import Post from '/admin/templates/post.js'

CMS.registerLocale('fr', fr);
CMS.registerPreviewStyle('/styles.min.css');
CMS.registerPreviewTemplate('billets', Post);
