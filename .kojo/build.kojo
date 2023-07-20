name: Build boxes
on: [push, pull_request, workflow_dispatch]
jobs:
  run-packer:
    runs-on: macos-12
    timeout-minutes: 30
    env:
      MAKE_VARS: --dry-run
      PACKER_GITHUB_API_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      VAGRANT_CLOUD_TOKEN: ${{ secrets.VAGRANT_CLOUD_TOKEN }}
    strategy:
      fail-fast: false
      matrix:
        version: [tkl16, tkl17]
    steps:
      - name: Prepare environment
        run: |
          brew install make
      - name: Checkout repository
        uses: actions/checkout@v3
      - name: Set to not dry-run
        if: github.event_name != 'push'
        run: |
          echo "MAKE_VARS=" >> $GITHUB_ENV
<% %w(boot install kernel update export).each do |stage| -%>
      - name: Packer <%= stage %>
        run: |
          gmake ${{ env.MAKE_VARS }} <%= stage %>-${{ matrix.version }}
<% end -%>
      - name: Packer upload
        if: github.ref_name == 'main'
        env:
          PKR_VAR_no_release: false
        run: |
          cd upload
          gmake ${{ env.MAKE_VARS }} ${{ matrix.version }}
