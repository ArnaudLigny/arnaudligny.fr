import { defineConfig } from "tinacms";

// Your hosting provider likely exposes this as an environment variable
const branch = process.env.HEAD || process.env.VERCEL_GIT_COMMIT_REF || "main";

export default defineConfig({
  branch,
  clientId: null, // Get this from tina.io
  token: null, // Get this from tina.io
  build: {
    outputFolder: "admin",
    publicFolder: "static",
  },
  media: {
    tina: {
      publicFolder: "static",
      mediaRoot: "",
    },
  },
  schema: {
    collections: [
      {
        label: "Billets",
        name: "billets",
        path: "pages/blog",
        fields: [
          {
            type: "string",
            name: "title",
            label: "Title",
            required: true,
          },
          {
            type: "datetime",
            name: "date",
            label: "Date",
            required: true,
          },
          {
            type: "rich-text",
            name: "body",
            label: "Body",
            isBody: true,
          },
          {
            type: "image",
            name: "image",
            label: "Image",
          },
          {
            type: "string",
            name: "tags",
            label: "Tags",
            list: true,
            ui: {
              component: "tags",
            },
          },
          {
            type: "boolean",
            name: "published",
            label: "Published",
          },
        ],
      },
      {
        label: "Tags",
        name: "tags",
        path: "pages/tags",
        fields: [
          {
            type: "rich-text",
            name: "body",
            label: "Body of Document",
            description: "This is the markdown body",
            isBody: true,
          },
        ],
      },
      {
        label: "Pages",
        name: "pages",
        path: "pages",
        fields: [
          {
            type: "rich-text",
            name: "body",
            label: "Body of Document",
            description: "This is the markdown body",
            isBody: true,
          },
        ],
      },
      {
        label: "Projets",
        name: "projets",
        path: "pages/projets",
        fields: [
          {
            type: "rich-text",
            name: "body",
            label: "Body of Document",
            description: "This is the markdown body",
            isBody: true,
          },
          {
            type: "string",
            name: "title",
            label: "Title",
            required: true,
          },
          {
            type: "datetime",
            name: "date",
            label: "Date",
            required: true,
          },
          {
            type: "number",
            name: "weight",
            label: "Weight",
            required: true,
          },
          {
            type: "string",
            name: "redirect",
            label: "Redirect",
            required: true,
          },
          {
            type: "boolean",
            name: "published",
            label: "Published",
          },
          {
            type: "string",
            name: "alias",
            label: "Alias",
            list: true,
          },
          {
            type: "string",
            name: "typora_root_url",
            label: "typora-root-url",
          },
        ],
      },
    ],
  },
});
