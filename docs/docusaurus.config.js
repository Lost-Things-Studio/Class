const lightCodeTheme = require("prism-react-renderer").themes.github;
const darkCodeTheme = require("prism-react-renderer").themes.dracula;

const config = {
  title: "Class",
  tagline: "A lightweight OOP helper for Lua.",

  url: "https://gopmyc.github.io",
  baseUrl: "/Class/",

  organizationName: "Gopmyc",
  projectName: "Class",
  trailingSlash: false,

  onBrokenLinks: "throw",
  markdown: {
    hooks: {
      onBrokenMarkdownLinks: "warn",
    },
  },

  i18n: {
    defaultLocale: "en",
    locales: ["en"],
  },

  presets: [
    [
      "classic",
      {
        docs: {
          path: "content",
          routeBasePath: "/",
          sidebarPath: require.resolve("./sidebars.js"),
          editUrl: "https://github.com/Gopmyc/Class/edit/main/docs/",
        },
        blog: false,
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      },
    ],
  ],

  themeConfig: {
    image: "img/social_preview.jpg",
    navbar: {
      title: "Class",
      items: [
        {
          to: "/getting-started",
          label: "Docs",
          position: "left",
        },
        {
          to: "/api/class-factory",
          label: "API",
          position: "left",
        },
        {
          href: "https://github.com/Gopmyc/Class",
          label: "GitHub",
          position: "right",
        },
      ],
    },
    footer: {
      style: "dark",
      links: [
        {
          title: "Docs",
          items: [
            {
              label: "Getting Started",
              to: "/getting-started",
            },
            {
              label: "API Reference",
              to: "/api/class-factory",
            },
          ],
        },
        {
          title: "Project",
          items: [
            {
              label: "GitHub",
              href: "https://github.com/Gopmyc/Class",
            },
            {
              label: "Issues",
              href: "https://github.com/Gopmyc/Class/issues",
            },
          ],
        },
        {
          title: "Community",
          items: [
            {
              label: "Contributing",
              to: "/contributing",
            },
            {
              label: "Code of Conduct",
              href: "https://github.com/Gopmyc/Class/blob/main/CODE_OF_PRODUCT.md",
            },
          ],
        },
      ],
      copyright: `Copyright (c) ${new Date().getFullYear()} Gopmyc. Built with Docusaurus.`,
    },
    prism: {
      theme: lightCodeTheme,
      darkTheme: darkCodeTheme,
      additionalLanguages: ["lua"],
    },
    colorMode: {
      defaultMode: "light",
      respectPrefersColorScheme: true,
    },
  },
};

module.exports = config;
