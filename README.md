<!-- markdownlint-disable -->
<p align="center">
    <a href="https://github.com/MonitoringToolbox/">
        <img src="https://cdn.wolfsoftware.com/assets/images/github/organisations/monitoringtoolbox/black-and-white-circle-256.png" alt="MonitoringToolbox logo" />
    </a>
    <br />
    <a href="https://github.com/MonitoringToolbox/nagios-plugins/actions/workflows/cicd.yml">
        <img src="https://img.shields.io/github/actions/workflow/status/MonitoringToolbox/nagios-plugins/cicd.yml?branch=master&label=build%20status&style=for-the-badge" alt="Github Build Status" />
    </a>
    <a href="https://github.com/MonitoringToolbox/nagios-plugins/blob/master/LICENSE.md">
        <img src="https://img.shields.io/github/license/MonitoringToolbox/nagios-plugins?color=blue&label=License&style=for-the-badge" alt="License">
    </a>
    <a href="https://github.com/MonitoringToolbox/nagios-plugins">
        <img src="https://img.shields.io/github/created-at/MonitoringToolbox/nagios-plugins?color=blue&label=Created&style=for-the-badge" alt="Created">
    </a>
    <br />
    <a href="https://github.com/MonitoringToolbox/nagios-plugins/releases/latest">
        <img src="https://img.shields.io/github/v/release/MonitoringToolbox/nagios-plugins?color=blue&label=Latest%20Release&style=for-the-badge" alt="Release">
    </a>
    <a href="https://github.com/MonitoringToolbox/nagios-plugins/releases/latest">
        <img src="https://img.shields.io/github/release-date/MonitoringToolbox/nagios-plugins?color=blue&label=Released&style=for-the-badge" alt="Released">
    </a>
    <a href="https://github.com/MonitoringToolbox/nagios-plugins/releases/latest">
        <img src="https://img.shields.io/github/commits-since/MonitoringToolbox/nagios-plugins/latest.svg?color=blue&style=for-the-badge" alt="Commits since release">
    </a>
    <br />
    <a href="https://github.com/MonitoringToolbox/nagios-plugins/blob/master/.github/CODE_OF_CONDUCT.md">
        <img src="https://img.shields.io/badge/Code%20of%20Conduct-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/MonitoringToolbox/nagios-plugins/blob/master/.github/CONTRIBUTING.md">
        <img src="https://img.shields.io/badge/Contributing-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/MonitoringToolbox/nagios-plugins/blob/master/.github/SECURITY.md">
        <img src="https://img.shields.io/badge/Report%20Security%20Concern-blue?style=for-the-badge" />
    </a>
    <a href="https://github.com/MonitoringToolbox/nagios-plugins/issues">
        <img src="https://img.shields.io/badge/Get%20Support-blue?style=for-the-badge" />
    </a>
</p>

## Background

Wolf Software has been engaged in providing system, network, and security monitoring solutions from the very outset. Our expertise encompasses a wide range of monitoring solutions, including fundamental ones such as [Munin](http://munin-monitoring.org/) and [Nagios](https://www.nagios.org/), as well as sophisticated enterprise-grade solutions like [New Relic](https://newrelic.com/), [Datadog](https://www.datadoghq.com/), and [AppDynamics](https://www.appdynamics.com/). We also possess experience in creating customized monitoring solutions in-house, tailored to specific client requirements.

## Overview

It is a common occurrence for companies to express the need for ready-made enterprise-grade monitoring solutions, asserting that solutions like [Nagios](https://www.nagios.org/) are becoming obsolete due to the significant investment of time and resources required to make it operational, resulting in similar costs as those incurred with off-the-shelf solutions.

The goal of this project, as well as other initiatives within [The Monitoring Toolbox](https://github.com/MonitoringToolbox), is to demonstrate the ease with which plugins can be developed for tools like [Nagios](https://www.nagios.org/) and [Munin](http://munin-monitoring.org/), thereby enhancing their capabilities to a level that is more comparable to the more costly off-the-shelf alternatives.

## The Plugins

We have developed a collection of plugins using the templates we created, and we plan to keep expanding this collection with additional plugins in the future.

| Plugin                                                              | Category            | Description                              |
| ------------------------------------------------------------------- | ------------------- | ---------------------------------------- |
| [check_disk_percentage.sh](plugins/disk/check_disk_percentage.sh)   | Disk Metrics        | Check total disk usage as a percentage.  |
| [check_inode_percentage.sh](plugins/disk/check_inode_percentage.sh) | Disk Metrics        | Check total inode usage as a percentage. |
| [check_load_average.sh](plugins/performance/check_load_average.sh)  | Performance Metrics | Check server load average.               |

## Template Scripts

We provide a number of templates in various languages, as individuals and organizations often have a particular language preference or choice.

* [Bash](https://github.com/MonitoringToolbox/nagios-plugin-bash-templates)
* [Perl](https://github.com/MonitoringToolbox/nagios-plugin-perl-templates)
* [Powershell](https://github.com/MonitoringToolbox/nagios-plugin-powershell-templates)
* [Python](https://github.com/MonitoringToolbox/nagios-plugin-python-templates)
* [Ruby](https://github.com/MonitoringToolbox/nagios-plugin-ruby-templates)

<br />
<p align="right"><a href="https://wolfsoftware.com/"><img src="https://img.shields.io/badge/Created%20by%20Wolf%20on%20behalf%20of%20Wolf%20Software-blue?style=for-the-badge" /></a></p>
