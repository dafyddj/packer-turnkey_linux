name: Build dev boxes

on: [push, pull_request, workflow_dispatch]

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

jobs:
  gov:
    name: Get OS versions
    runs-on: ubuntu-latest
    timeout-minutes: 5
    outputs:
      os-versions: ${{ steps.get-os-versions.outputs.os-versions }}
    steps:
      - uses: actions/checkout@v3
      - id: get-os-versions
        run: |
          VERSIONS=$(jq -cR 'split(" ")' os_vers)
          OUTPUT="os-versions=$VERSIONS"
          echo "Setting '$OUTPUT'"
          echo "$OUTPUT" >> $GITHUB_OUTPUT
  run-packer:
    runs-on: macos-12
    timeout-minutes: 30
    needs: gov
    env:
      MAKE_VARS: --dry-run
      PACKER_GITHUB_API_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      VAGRANT_CLOUD_TOKEN: ${{ secrets.VAGRANT_CLOUD_TOKEN }}
    strategy:
      fail-fast: false
      matrix:
        version: ${{ fromJSON(needs.gov.outputs.os-versions) }}
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
<% IO.binread("stages").split.each do |stage| -%>
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
